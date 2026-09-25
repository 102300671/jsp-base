package place.run.jianying.lab2.Phone;

public class Fixedphone extends Phone {
    private String location;
    private String lineId;

    public Fixedphone(String number, String location, String lineId) {
        super(number);
        this.location = location;
        this.lineId = lineId;
    }

    @Override
    public void makeCall(String to) {
        System.out.println("固定电话 " + getNumber() + " (线路" + lineId + ") 在 " + location + " 拨打 " + to);
    }


    public void pickUpHandset() {
        System.out.println(getNumber() + " 拿起话筒");
    }


    public void putDownHandset() {
        System.out.println(getNumber() + " 放下话筒");
    }
}
