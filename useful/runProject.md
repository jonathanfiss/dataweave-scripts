# Run Project

## Autodiscovery

```shell
-Danypoint.platform.gatekeeper=disabled 
```

## Set timezone language region

[List timezone](https://docs.mulesoft.com/dataweave/2.3/dataweave-cookbook-change-time-zone)
[List language and regions](https://www.oracle.com/java/technologies/javase/jdk8-jre8-suported-locales.html)

```shell
-Duser.timezone=UTC -Duser.language=en -Duser.region=US
```

## Simulate vCore

### 0.1 vCore

```shell
-Xms480m
-Xmx480m
-XX:ReservedCodeCacheSize=64m
-XX:MaxDirectMemorySize=32m
-XX:MaxMetaspaceSize=256m
```

## batch persistent queue

```shell
-Dbatch.persistent.queue.disable=true
```