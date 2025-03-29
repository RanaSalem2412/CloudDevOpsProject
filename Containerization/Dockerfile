
FROM amazoncorretto:17                                                                                                                                                                                                                          
RUN yum install -y git


WORKDIR /app

RUN git clone https://github.com/IbrahimAdell/FinalProjectCode.git /app


WORKDIR /app/web-app


RUN chmod +x gradlew


RUN ./gradlew build -x test


RUN cp build/libs/*SNAPSHOT.jar app.jar



EXPOSE 8080


CMD ["java", "-jar", "app.jar"]
                                                    
