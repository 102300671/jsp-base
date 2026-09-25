package place.run.jianying.lab2.Phone;

public class Cordlessphone extends Fixedphone {
    private int distance;
    private boolean handsetOnBase;

    public Cordlessphone(String number, String location, String lineId, int distance) {
        super(number, location, lineId);
        this.distance = distance;
        this.handsetOnBase = true;
    }

    @Override
    public void makeCall(String to) {
        if (handsetOnBase) {
            System.out.println("无绳电话 " + getNumber() + " 听筒在座机上，无法拨打");
            return;
        }
        System.out.println("无绳电话 " + getNumber() + " (距座机≤" + distance + "米) 拨打 " + to);
    }

    public void leaveBase() {
        handsetOnBase = false;
        System.out.println(getNumber() + " 听筒离开座机");
    }

    public void returnBase() {
        handsetOnBase = true;
        System.out.println(getNumber() + " 听筒放回座机");
    }
}
