package place.run.jianying.lab2.Phone;

public class Phone {
    private String number;

    public Phone(String number) {
        this.number = number;
    }

    public String getNumber() {
        return number;
    }

    public void makeCall(String to) {
        System.out.println(number + " 正在拨打 " + to);
    }

    public void answerCall() {
        System.out.println(number + " 接到来电");
    }

    public void hangUp() {
        System.out.println(number + " 已挂断");
    }

    @Override
    public String toString() {
        return "电话[本机号码=" + number + "]";
    }
}
