

## Containerising Pet Clinic app using Docker

This is a [dockerized version of the original app](https://github.com/CloudHight/application-assessment-repo.git) published by Cloudhight


## Running PetClinic app locally

Petclinic is a [Spring Boot](https://spring.io/guides/gs/spring-boot) application built using Maven. It is an application designed to show how the Spring stack can be used to build simple, but powerful database-oriented applications. The official version of PetClinic demonstrates the use of Spring Boot with Spring MVC and Spring Data JPA.

## How it works?

Spring boot works with MVC (Model-View-Controller) is a pattern in software design commonly used to implement user interfaces, data and control logic. It emphasizes a separation between business logic and its visualization. This "separation of concerns" provides a better division of labor and improved maintenance.We can work with the persistence or data access layer with [spring-data](https://spring.io/projects/spring-data) in a simple and very fast way, without the need to create so many classes manually. Spring data comes with built-in methods below or by default that allow you to save, delete, update and/or create.


## Getting Started
## Forked the repository from  https://github.com/dockersamples/spring-petclinic.git and then it to my local

```

git clone https://github.com/dockersamples/spring-petclinic.git
cd application-assessment-repo
./mvnw package
java -jar target/*.war
```

You can then access petclinic here: http://localhost:8080/

<img width="625" alt="image" src="https://user-images.githubusercontent.com/313480/179161406-54a28200-d52e-411f-bfbe-463cf64b64b3.png">

The applications allows you to perform the following set of functions:

- Add Pets
- Add Owners
- Finding Owners
- Finding Veterinarians
- Exceptional handling


## Building a Container

```
 docker build -t petclinic-app . -f Dockerfile
```


## References

- [Building PetClinic app using Dockerfile](https://docs.docker.com/language/java/build-images/)