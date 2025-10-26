package MyAnnotation;

import framework.annotation.Controller;
import framework.annotation.MyAnnotation;

@Controller(value = "/hello")
public class HelloController {
    @MyAnnotation(value = "/sayHello")
    public void sayHello() {
        System.out.println("HelloController.sayHello()");
    }
}