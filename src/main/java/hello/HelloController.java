package hello;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
public class HelloController {

    InetAddress ip;
    String hostname;

    @RequestMapping("/")
        public String index() {
            try {

                ip = InetAddress.getLocalHost();
                //hostname = ip.getHostName();
            } catch (UnknownHostException e) {

                e.printStackTrace();
            }

            return "<h1 style=\"color:green;\">Hi! I'm running on: " + ip + "</h1>";
        }
    @RequestMapping("/hello")
        public String index2() {

            return "Hello, World!\n";
        }

}
