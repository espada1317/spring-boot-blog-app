FROM openjdk:17

# Copy maven executable to the image
COPY mvnw .
COPY .mvn .mvn

# Copy the pom.xml file
COPY pom.xml .

# Copy the project source
COPY ./src ./src
COPY ./pom.xml ./pom.xml

RUN ./mvnw dependency:go-offline -B
RUN ./mvnw install -DskipTests

VOLUME /tmp
COPY target/*.jar spring-boot-note-app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/spring-boot-note-app.jar"]

