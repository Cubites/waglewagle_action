package kr.co.waglewagle.goods.won;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.StringJoiner;

public class Test {

	public static void main(String[] args) {
		//Date객체 구하기 
		java.util.Date now = new java.util.Date();
		Date dat = new Date(now.getTime());
		
		//현재시간 구하기 
		LocalTime nowTime = LocalTime.now();
		DateTimeFormatter fomatter = DateTimeFormatter.ofPattern("HH:mm:ss");
		String nowTimeString = nowTime.format(fomatter);
		
		String TimeStampString = dat+" "+nowTimeString;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//TimeStamp st = new Timestamp(0);
		try {
			java.util.Date timeSDate = dateFormat.parse(TimeStampString);
			Timestamp st = new Timestamp(timeSDate.getTime());
			System.out.println(st.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		System.out.println(nowTime);
	}
}
