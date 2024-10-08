FROM gradle:7.6.2 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon 

FROM openjdk:17-jdk-slim
COPY --from=build /home/gradle/src/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]