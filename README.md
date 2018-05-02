# PingTestForIos
Ping 网络检测工具，主要使用在iOSapp测试服务器或者用户网络状况场合。
https://github.com/lmirosevic/GBPing  使用第三方库地址

GBPing provides the following info (inside a GBPingSummaryObject exposed as properties):

NSUInteger sequenceNumber;
NSUInteger payloadSize;
NSUInteger ttl;
NSString *host;
NSDate *sendDate;
NSDate *receiveDate;
NSTimeInterval rtt;
GBPingStatus status;
