package MyAnnotation;

import framework.annotation.Controller;
import framework.annotation.MyAnnotation;

@Controller(value = "/bye")
public class ByeController {
    @MyAnnotation(value = "/sayBye")
    public void sayBye() {
        System.out.println("ByeController.sayBye()");
    }
}