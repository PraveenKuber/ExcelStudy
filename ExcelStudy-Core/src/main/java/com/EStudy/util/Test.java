package com.EStudy.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by praveen on 26/2/19.
 */
public class Test {
    private Date getEndDate(Date startDate) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        calendar.add(Calendar.MONTH, 1);
        calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        Date nextMonthLastDay = calendar.getTime();
        return nextMonthLastDay;
    }

    public static void main(String[] args) throws ParseException {
        Test test = new Test();
        String date = "01 December 2017";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd MMMM yyyy");
        Date date1 = test.getEndDate(simpleDateFormat.parse(date));
        System.out.println("End Date is :::::::::::"+date1);
    }
}
