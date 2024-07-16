package dev.young.timeZY;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = "dev.young.timeZY")
public class TimeZyApplication {

	public static void main(String[] args) {
		SpringApplication.run(TimeZyApplication.class, args);
	}

}