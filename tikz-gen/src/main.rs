use std::f64::consts::PI;
const RADIUS: f64 = 0.9;
const DISTANCE: f64 = 4.0;
const ALPHA_ARROWS: f64 = PI * (5.0 / 180.0);

struct Point {x: f64, y: f64}

fn get_circles_centers() -> (Point, Point, Point, Point){
    let left: Point = Point {x: -DISTANCE * (PI / 6.0).cos(), y: -DISTANCE * (PI / 6.0).sin()};
    let central: Point = Point{x: 0.0, y: 0.0};
    let top: Point = Point {x: central.x, y: DISTANCE};
    let right: Point = Point {x: DISTANCE * (PI / 6.0).cos(), y: -DISTANCE * (PI / 6.0).sin()};
    (left, top, central, right)
}


fn print_arrows_to_right() {
    let (lt, tp, _, rt) = get_circles_centers();
    let alpha_next: f64 = PI * 1.0 / 6.0 + ALPHA_ARROWS;
    let top_left = Point {
        x: RADIUS * alpha_next.cos(),
        y: -RADIUS * alpha_next.sin(),
    };


    let alpha_next: f64 = PI*1.0/6.0-ALPHA_ARROWS;
    let bottom_left = Point{x: rt.x - RADIUS * alpha_next.cos(), 
                            y: rt.y + RADIUS * alpha_next.sin()};
    //let top_right = Point {
    //    x: RADIUS * (PI * 2.0 / 3.0 - ALPHA_ARROWS).cos(),
    //    y: -RADIUS * (PI * 2.0 / 3.0 - ALPHA_ARROWS).sin(),
    //};
    //let bottom_right = Point{x:, y:};
    print_arrow(top_left, bottom_left);
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
    let (lt, tp, cr, rt) = get_circles_centers();
    print_circle_center(cr);
    print_circle_center(tp);
    print_circle_center(rt);
    print_circle_center(lt);
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
    print_arrows_to_right();
}
