package com.smart.statuscodeconstant;

public class EveryApprovalCode {
    public static final Integer Accept = 1;
    public static final Integer NotAccept = 0;

    public static class First{
        public static final Integer Accept = EveryApprovalCode.Accept;
        public static final Integer NotAccept = EveryApprovalCode.NotAccept;
    }

    public static class Second{
        public static final Integer Accept = EveryApprovalCode.Accept;
        public static final Integer NotAccept = EveryApprovalCode.NotAccept;
    }

    public static class Third{
        public static final Integer Accept = EveryApprovalCode.Accept;
        public static final Integer NotAccept = EveryApprovalCode.NotAccept;
    }
}
