package org.example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Hello world!
 *
 */
public class App 
{
    private static final Logger logger
            = LoggerFactory.getLogger(App.class);

    public static void main( String[] args)
    {
        String version = args[0];
        String appName = System.getenv("APP_NAME");
        String env = System.getenv("ENV");

        logger.info( "Hello World! " + version + " " + appName + " " + env);
    }
}
