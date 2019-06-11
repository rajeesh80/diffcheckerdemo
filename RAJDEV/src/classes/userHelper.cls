public class userHelper {
    public static void updateUser(List<User> userList){
        system.debug('inside user helper class'+userList);
        for(User usr: userList){
            usr.ForecastEnabled = true;
            //usr.
        }
    }
}