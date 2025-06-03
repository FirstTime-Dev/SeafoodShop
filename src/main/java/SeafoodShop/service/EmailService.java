package SeafoodShop.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.security.SecureRandom;
import java.util.Properties;

public class EmailService {

    public static String generateOTP() {
        String DIGITS = "0123456789";
        int OTP_LENGTH = 6;
        SecureRandom random = new SecureRandom();
        StringBuilder otp = new StringBuilder(OTP_LENGTH);
        for (int i = 0; i < OTP_LENGTH; i++) {
            int index = random.nextInt(DIGITS.length());
            otp.append(DIGITS.charAt(index));
        }
        return otp.toString();
    }
    public static void sendEmail(String toEmail, String otp) throws MessagingException {
        final String fromEmail = "vantan232004@gmail.com";
        final String password = "fynzrwedzvyniavk"; // không dùng mật khẩu tài khoản Gmail trực tiếp

        // Cấu hình SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo session có xác thực
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // Soạn email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("We send your OTP");
        message.setText(otp);

        // Gửi
        Transport.send(message);
    }

}