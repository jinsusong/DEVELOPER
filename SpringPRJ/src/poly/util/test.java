package poly.util;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String chgdt = "2019-01-01 01:48:44";
		String hour = chgdt.substring(11, 13);
		
		
		String hour1 = chgdt.substring(11, 12);
		String hour2 = chgdt.substring(12, 13);
		String hour3 = chgdt.substring(11, 13);
		String minute = chgdt.substring(14, 16);
		
		System.out.println(hour);
		System.out.println(hour1);
		System.out.println(hour2);
		System.out.println(hour3);
		System.out.println(minute);
	}

}
