public class test123 {

public Account aName;

    public String getAccount() {
        return null;
    }
    public test123(){
    aName=[Select Id,Name From Account where Id =:apexpages.currentpage().getparameters().get('Id')];
    
    }

}