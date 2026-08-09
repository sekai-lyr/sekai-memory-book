package com.sekai.memory.book.config;

import com.sekai.memory.book.util.UploadPathUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

@Configuration
public class UploadResourceConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        Path uploadRoot = UploadPathUtil.uploadRoot();
        try {
            Files.createDirectories(UploadPathUtil.quoteVideoRoot());
            Files.createDirectories(UploadPathUtil.screenshotRoot());
        } catch (IOException e) {
            throw new IllegalStateException("Unable to prepare upload directories", e);
        }
        String uploadPath = uploadRoot.toUri().toString();
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadPath);
    }
}
