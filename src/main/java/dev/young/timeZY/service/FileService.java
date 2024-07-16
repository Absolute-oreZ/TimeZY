package dev.young.timeZY.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;

import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.InputStream;

@Service
public class FileService {

    @Autowired
    private ServletContext servletContext;

    public byte[] loadFile(String filePath) throws IOException {
        try (InputStream inputStream = servletContext.getResourceAsStream("/public/assets/images/" + filePath)) {
            if (inputStream == null) {
                throw new IOException("File not found: " + filePath);
            }
            return StreamUtils.copyToByteArray(inputStream);
        }
    }
}
