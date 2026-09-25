package place.run.jianying.lab2.Phone;

public class Test {
    public static void main(String[] args) {
        Phone[] phones = {
            new Mobilephone("13800000001", 50, "公司"),
            new Fixedphone("010-62770001", "客厅", "L01"),
            new Cordlessphone("010-62770002", "卧室", "L02", 50),
        };

        for (Phone p : phones) {
            p.makeCall("110");
            p.answerCall();
            p.hangUp();
            System.out.println(p);
            System.out.println("-----");
        }

        Moveable m = new Mobilephone("13800000002", 80, "家");
        m.move();

        Cordlessphone c = new Cordlessphone("010-62770003", "书房", "L03", 30);
        c.makeCall("120");
        c.leaveBase();
        c.makeCall("120");
        c.returnBase();
    }
}
