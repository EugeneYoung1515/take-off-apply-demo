package com.smart.statuscodeconstant;

public class TakeOffStatusCode {
    public static final Integer Off_Prepared = 0;//请假单已经提交 但是没有被审批
    public static final Integer Is_Accepted_By_First = 1;
    public static final Integer Is_Accepted_By_Second = 2;
    public static final Integer Is_Accepted_By_Third = 3;
    public static final Integer Is_Not_Accepted = 4;//在任意一级被驳回
}
