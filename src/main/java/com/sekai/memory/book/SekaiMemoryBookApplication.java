package com.sekai.memory.book;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.sekai.memory.book.mapper")
public class SekaiMemoryBookApplication {
    

    public static void main(String[] args) {
        SpringApplication.run(SekaiMemoryBookApplication.class, args);
    }
}
