package place.run.jianying.lab2.Phone;

public class Mobilephone extends Phone implements Moveable {
    private int battery;
    private String location;

    public Mobilephone(String number, int battery, String location) {
        super(number);
        this.battery = battery;
        this.location = location;
    }

    @Override
    public void makeCall(String to) {
        System.out.println("移动电话 " + getNumber() + " (电量" + battery + "%) 在 " + location + " 拨打 " + to);
    }

    @Override
    public void move() {
        System.out.println("移动电话 " + getNumber() + " 正从 " + location + " 移动到新位置");
    }


    public void sendSMS(String to, String text) {
        System.out.println(getNumber() + " 发短信给 " + to + "：" + text);
    }

    public void charge() {
        battery = 100;
        System.out.println(getNumber() + " 充电完成");
    }
}
