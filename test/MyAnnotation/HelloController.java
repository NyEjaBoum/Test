package MyAnnotation;

import framework.annotation.Controller;
import framework.annotation.MyAnnotation;
import framework.view.ModelView;

@Controller(value = "/hello")
public class HelloController {
    @MyAnnotation(value = "/sayHello")
    public void sayHello() {
        System.out.println("HelloController.sayHello()");
    }

    @MyAnnotation(value = "/getString")
    public String getString() {
        System.out.println("HelloController.getString()");
        return "Bonjour depuis HelloController!";
    }

    // retourne ModelView -> forward vers JSP
    @MyAnnotation(value = "/getView")
    public ModelView getView() {
        System.out.println("HelloController.getView()");
        ModelView mv = new ModelView();
        mv.setView("WEB-INF/test.jsp"); // ou "test.jsp" si JSP en racine webapp
        return mv;
    }

}