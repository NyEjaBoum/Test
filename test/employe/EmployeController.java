package employe;
import framework.annotation.Controller;
import framework.annotation.MyAnnotation;

@Controller(value = "/employe")
public class EmployeController {
    @MyAnnotation(value = "/list")
    public void getList() {
        System.out.println("EmployeController.getList()");
    }

    @MyAnnotation(value = "/inr")
    public int getInt() {
        System.out.println("EmployeController.getInt()");
        return 42;
    }
}