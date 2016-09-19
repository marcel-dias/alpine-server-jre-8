[![](https://images.microbadger.com/badges/image/marceldiass/alpine-server-jre-8.svg)](https://microbadger.com/images/marceldiass/alpine-server-jre-8 "Get your own image badge on microbadger.com")

# alpine-server-jre-8
It is an AlpineLinux 4.3 with Oracle Server JRE 8 image

## How to use it
```bash
❯ docker run -ti --rm marceldiass/alpine-server-jre-8 java -version
java version "1.8.0_92"
Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)
```

## Extending it
Create a simple java HelloWorld class. You can see the example [here](https://github.com/marceldiass/alpine-server-jre-8/tree/master/extends)
```bash
echo 'public class HelloWorld { public static void main(String... a) {System.out.println("Java Hello World into a Docker Container!!");}}' > HelloWorld.java
```
```Dockerfile
FROM marceldiass/alpine-server-jre-8
ADD HelloWorld.java /home/
WORKDIR /home
RUN javac HelloWorld.java
CMD java HelloWorld
```

Then you need to build it
```bash
❯ docker build -t your-image-name .
```
And you can run it
```bash
❯ docker run -ti --rm your-image-name
Java Hello World into a Docker Container!!
```
