//
//  UIViewController+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 27/05/2022.
//

import Foundation
import SystemConfiguration

public enum ReachabilityError: Error {
    case failedToCreateWithAddress(sockaddr_in)
    case failedToCreateWithHostname(String)
    case unableToSetCallback
    case unableToSetDispatchQueue
}

@available(*, unavailable, renamed: "Notification.Name.reachabilityChanged")
public let reachabilityChangedNotification = NSNotification.Name("ReachabilityChangedNotification")

extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
}

func callback(
    reachability _: SCNetworkReachability,
    flags _: SCNetworkReachabilityFlags,
    info: UnsafeMutableRawPointer?
) {
    guard let info = info else { return }

    let reachability = Unmanaged<Reachability>.fromOpaque(info).takeUnretainedValue()
    reachability.reachabilityChanged()
}

public class Reachability {
    public typealias NetworkReachable = (Reachability) -> Void
    public typealias NetworkUnreachable = (Reachability) -> Void

    @available(*, unavailable, renamed: "Connection")
    public enum NetworkStatus: CustomStringConvertible {
        case notReachable, reachableViaWiFi, reachableViaWWAN
        public var description: String {
            switch self {
            case .reachableViaWWAN: return "Cellular"
            case .reachableViaWiFi: return "WiFi"
            case .notReachable: return "No Connection"
            }
        }
    }

    public enum Connection: CustomStringConvertible {
        case none, wifi, cellular
        public var description: String {
            switch self {
            case .cellular: return "Cellular"
            case .wifi: return "WiFi"
            case .none: return "No Connection"
            }
        }
    }

    public var whenReachable: NetworkReachable?
    public var whenUnreachable: NetworkUnreachable?

    @available(*, deprecated, renamed: "allowsCellularConnection")
    public let reachableOnWWAN = true

    /// Set to `false` to force Reachability.connection to .none when on cellular connection (default value `true`)
    public var allowsCellularConnection: Bool

    // The notification center on which "reachability changed" events are being posted
    public var notificationCenter: NotificationCenter = .default

    @available(*, deprecated, renamed: "connection.description")
    public var currentReachabilityString: String {
        "\(connection)"
    }

    @available(*, unavailable, renamed: "connection")
    public var currentReachabilityStatus: Connection {
        connection
    }

    public var connection: Connection {
        guard isReachableFlagSet else { return .none }

        // If we're reachable, but not on an iOS device (i.e. simulator), we must be on WiFi
        guard isRunningOnDevice else { return .wifi }

        var connection = Connection.none

        if !isConnectionRequiredFlagSet {
            connection = .wifi
        }

        if isConnectionOnTrafficOrDemandFlagSet {
            if !isInterventionRequiredFlagSet {
                connection = .wifi
            }
        }

        if isOnWWANFlagSet {
            if !allowsCellularConnection {
                connection = .none
            } else {
                connection = .cellular
            }
        }

        return connection
    }

    private var previousFlags: SCNetworkReachabilityFlags?

    private var isRunningOnDevice: Bool = {
#if targetEnvironment(simulator)
        return false
#else
        return true
#endif
    }()

    private var notifierRunning = false
    private let reachabilityRef: SCNetworkReachability

    private let reachabilitySerialQueue = DispatchQueue(label: "uk.co.ashleymills.reachability")

    private var usingHostname = false

    public required init(reachabilityRef: SCNetworkReachability, usingHostname: Bool = false) {
        self.allowsCellularConnection = true
        self.reachabilityRef = reachabilityRef
        self.usingHostname = usingHostname
    }

    public convenience init?(hostname: String) {
        guard let ref = SCNetworkReachabilityCreateWithName(nil, hostname) else { return nil }
        self.init(reachabilityRef: ref, usingHostname: true)
    }

    public convenience init?() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        guard let ref = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress) else { return nil }

        self.init(reachabilityRef: ref)
    }

    deinit {
        stopNotifier()
    }
}

extension Reachability {
    // MARK: - *** Notifier methods ***

    func startNotifier() throws {
        guard !notifierRunning else { return }

        var context = SCNetworkReachabilityContext(
            version: 0,
            info: nil,
            retain: nil,
            release: nil,
            copyDescription: nil
        )
        context.info = UnsafeMutableRawPointer(Unmanaged<Reachability>.passUnretained(self).toOpaque())
        if !SCNetworkReachabilitySetCallback(reachabilityRef, callback, &context) {
            stopNotifier()
            throw ReachabilityError.unableToSetCallback
        }

        if !SCNetworkReachabilitySetDispatchQueue(reachabilityRef, reachabilitySerialQueue) {
            stopNotifier()
            throw ReachabilityError.unableToSetDispatchQueue
        }

        // Perform an initial check
        reachabilitySerialQueue.async {
            self.reachabilityChanged()
        }

        notifierRunning = true
    }

    func stopNotifier() {
        defer { notifierRunning = false }

        SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
    }

    // MARK: - *** Connection test methods ***

    @available(*, deprecated, message: "Please use `connection != .none`")
    var isReachable: Bool {
        guard isReachableFlagSet else { return false }

        if isConnectionRequiredAndTransientFlagSet {
            return false
        }

        if isRunningOnDevice {
            if isOnWWANFlagSet && !reachableOnWWAN {
                // We don't want to connect when on cellular connection
                return false
            }
        }

        return true
    }

    @available(*, deprecated, message: "Please use `connection == .cellular`")
    var isReachableViaWWAN: Bool {
        // Check we're not on the simulator, we're REACHABLE and check we're on WWAN
        return isRunningOnDevice && isReachableFlagSet && isOnWWANFlagSet
    }

    @available(*, deprecated, message: "Please use `connection == .wifi`")
    var isReachableViaWiFi: Bool {
        // Check we're reachable
        guard isReachableFlagSet else { return false }

        // If reachable we're reachable, but not on an iOS device (i.e. simulator), we must be on WiFi
        guard isRunningOnDevice else { return true }

        // Check we're NOT on WWAN
        return !isOnWWANFlagSet
    }

    var description: String {
        let wwan = isRunningOnDevice ? (isOnWWANFlagSet ? "W" : "-") : "X"
        let reachable = isReachableFlagSet ? "R" : "-"
        let connection = isConnectionRequiredFlagSet ? "c" : "-"
        let transient = isTransientConnectionFlagSet ? "t" : "-"
        let intervention = isInterventionRequiredFlagSet ? "i" : "-"
        let connectionOnTraffic = isConnectionOnTrafficFlagSet ? "C" : "-"
        let demand = isConnectionOnDemandFlagSet ? "D" : "-"
        let local = isLocalAddressFlagSet ? "l" : "-"
        let direct = isDirectFlagSet ? "d" : "-"

        return "\(wwan)\(reachable) \(connection)\(transient)\(intervention)\(connectionOnTraffic)\(demand)\(local)\(direct)"
    }
}

extension Reachability {
    func reachabilityChanged() {
        guard previousFlags != flags else { return }

        let block = connection != .none ? whenReachable : whenUnreachable

        DispatchQueue.main.async {
            if self.usingHostname {
                print("USING HOSTNAME ABOUT TO CALL BLOCK")
            }
            block?(self)
            self.notificationCenter.post(name: .reachabilityChanged, object: self)
        }

        previousFlags = flags
    }

    var isOnWWANFlagSet: Bool {
#if os(iOS)
        return flags.contains(.isWWAN)
#else
        return false
#endif
    }

    var isReachableFlagSet: Bool {
        flags.contains(.reachable)
    }

    var isConnectionRequiredFlagSet: Bool {
        flags.contains(.connectionRequired)
    }

    var isInterventionRequiredFlagSet: Bool {
        flags.contains(.interventionRequired)
    }

    var isConnectionOnTrafficFlagSet: Bool {
        flags.contains(.connectionOnTraffic)
    }

    var isConnectionOnDemandFlagSet: Bool {
        flags.contains(.connectionOnDemand)
    }

    var isConnectionOnTrafficOrDemandFlagSet: Bool {
        !flags.isDisjoint(with: [.connectionOnTraffic, .connectionOnDemand])
    }

    var isTransientConnectionFlagSet: Bool {
        flags.contains(.transientConnection)
    }

    var isLocalAddressFlagSet: Bool {
        flags.contains(.isLocalAddress)
    }

    var isDirectFlagSet: Bool {
        flags.contains(.isDirect)
    }

    var isConnectionRequiredAndTransientFlagSet: Bool {
        flags
            .intersection([.connectionRequired, .transientConnection]) == [.connectionRequired, .transientConnection]
    }

    var flags: SCNetworkReachabilityFlags {
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachabilityRef, &flags) {
            print("Returning flags \(flags)")
            return flags
        } else {
            return SCNetworkReachabilityFlags()
        }
    }
}
