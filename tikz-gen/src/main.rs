use std::f64::consts::PI;
const RADIUS: f64 = 0.9;
const DISTANCE: f64 = 4.0;
const ALPHA_ARROWS: f64 = PI * (5.0 / 180.0);

struct Point {
    x: f64,
    y: f64,
}

fn print_arrows_to_righ(){
    
}
fn print_arrows_to_top() {
    let right_bottom = Point {
        x: RADIUS * ALPHA_ARROWS.sin(),
        y: RADIUS * ALPHA_ARROWS.cos(),
    };
    let left_bottom = Point {
        x: -right_bottom.x,
        y: right_bottom.y,
    };
    let right_top = Point {
        x: right_bottom.x,
        y: DISTANCE - right_bottom.y,
    };
    let left_top = Point {
        x: -right_bottom.x,
        y: DISTANCE - right_bottom.y,
    };
    print_arrow(right_bottom, right_top);
    print_arrow(left_top, left_bottom);
}

fn print_arrow(from: Point, to: Point) {
    let rep = format!(
        "\\draw [->] ({:.2}, {:.2}) -- ({:.2}, {:.2});",
        from.x, from.y, to.x, to.y
    );
    println!("{}", rep);
}

fn print_circles_centers() {
    let central = Point { x: 0.0, y: 0.0 };
    let top = Point {
        x: central.x,
        y: DISTANCE,
    };
    let right = Point {
        x: DISTANCE * (PI / 6.0).cos(),
        y: -DISTANCE * (PI / 6.0).sin(),
    };
    let left = Point {
        x: -DISTANCE * (PI / 6.0).cos(),
        y: -DISTANCE * (PI / 6.0).sin(),
    };
    print_circle_center(central);
    print_circle_center(top);
    print_circle_center(right);
    print_circle_center(left);
}

fn print_circle_center(point: Point) {
    let rep = format!(
        "\\draw [black] ({:.2}, {:.2}) circle [radius={}];",
        point.x, point.y, RADIUS
    );
    println!("{}", rep);
}

fn main() {
    print_circles_centers();
    print_arrows_to_top();
}
