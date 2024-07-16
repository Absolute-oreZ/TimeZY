package dev.young.timeZY.service;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.InputStreamSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

import io.micrometer.common.util.StringUtils;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender emailSender;

    public void sendSimpleMessage(String to, String subject, String text) {
        try {
            MimeMessage message = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(to);
            helper.setSubject(subject);

            // Enable HTML content
            helper.setText(text, true);

            emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void sendEmailWithAttachment(String to, String subject, String text, String filename,
            InputStream attachment) {
        try {
            MimeMessage message = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(to);
            helper.setSubject(subject);

            // Enable HTML content
            helper.setText(text, true);

            // Add attachment
            if (attachment != null && !StringUtils.isEmpty(filename)) {
                helper.addAttachment(filename, new InputStreamSource() {
                    @SuppressWarnings("null")
                    @Override
                    public InputStream getInputStream() throws IOException {
                        return attachment;
                    }
                });
            }

            emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace(); // Replace with proper error handling
        }
    }

    public void sendEmailWithInlineImage(String to, String subject, String text, String imagePath) {
        try {
            MimeMessage message = emailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(to);
            helper.setSubject(subject);

            // Enable HTML content
            helper.setText(text, true);

            // Add inline image
            ClassPathResource resource = new ClassPathResource(imagePath);
            if (resource.exists()) {
                helper.addInline("logoImage", resource);
            }

            emailSender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace(); // Replace with proper error handling
        }
    }
}
