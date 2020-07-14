package action;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Conv {

	
	  private static String myCon(InputStream is) {

  		BufferedReader br = null;
  		StringBuilder sb = new StringBuilder();

  		String line;
  		try {

  			br = new BufferedReader(new InputStreamReader(is));
  			while ((line = br.readLine()) != null) {
  				sb.append(line);
  			}

  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return sb.toString();
	  }
}
