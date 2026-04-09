FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew bootJar --no-daemon -Dorg.gradle.jvmargs="-Xmx512m"

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-Xms128m", "-Xmx384m", "-XX:+UseSerialGC", "-jar", "app.jar"]
