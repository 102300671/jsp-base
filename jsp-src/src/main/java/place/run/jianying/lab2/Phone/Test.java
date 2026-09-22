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

        // 接口引用指向实现类对象
        Moveable m = new Mobilephone("13800000002", 80, "家");
        m.move();

        // 无绳电话状态机：听筒在座机上时打不出，离座后才能打
        Cordlessphone c = new Cordlessphone("010-62770003", "书房", "L03", 30);
        c.makeCall("120");          // 在座机上 → 拒绝
        c.leaveBase();              // 离座
        c.makeCall("120");          // 离座后 → 成功
        c.returnBase();             // 放回
    }
}
