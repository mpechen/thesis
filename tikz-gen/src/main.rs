use std::f64::consts::PI;
const RADIUS: f64 = 1.2;
const DISTANCE: f64 = 4.0;
const ALPHA_ARROWS: f64 = PI * (5.0 / 180.0);

struct Point {
    x: f64,
    y: f64,
}

struct Arc {
    origin: Point,
    destination: Point,
}

impl Arc {
    fn tikz_repr(&self) {
        let tikz_str = format!(
            "\\draw [->] ({:.2}, {:.2}) -- ({:.2}, {:.2});",
            self.origin.x, self.origin.y, self.destination.x, self.destination.y
        );
        println!("{}", tikz_str);
    }
}

fn calc_angle(a: f64, b: f64, c: f64) -> f64 {
    ((a.powf(2.0) + b.powf(2.0) - c.powf(2.0)) / (2.0 * a * b)).acos()
}

fn print_circle_center(point: Point) {
    let rep = format!(
        "\\draw [black] ({:.2}, {:.2}) circle [radius={}];",
        point.x, point.y, RADIUS
    );
    println!("{}", rep);
}

fn print_arrow(from: &Point, to: &Point) {
    let rep = format!(
        "\\draw [->] ({:.2}, {:.2}) -- ({:.2}, {:.2});",
        from.x, from.y, to.x, to.y
    );
    println!("{}", rep);
}

fn get_circles_centers() -> (Point, Point, Point, Point) {
    let central: Point = Point { x: 0.0, y: 0.0 };
    let top: Point = Point {
        x: central.x,
        y: DISTANCE,
    };
    let alpha = PI * (30.0 / 180.0);
    let left: Point = Point {
        x: -DISTANCE * alpha.cos(),
        y: -DISTANCE * alpha.sin(),
    };
    let right: Point = Point {
        x: DISTANCE * alpha.cos(),
        y: -DISTANCE * alpha.sin(),
    };
    (left, top, central, right)
}

fn print_circles_centers() {
    let (lt, tp, cr, rt) = get_circles_centers();
    print_circle_center(cr);
    print_circle_center(tp);
    print_circle_center(rt);
    print_circle_center(lt);
}

fn print_arrows_to_right_and_left_top() {
    let (_, _, _, rt) = get_circles_centers();

    // to the right
    let alpha_plus: f64 = PI * 1.0 / 6.0 + ALPHA_ARROWS;
    let alpha_minus: f64 = PI * 1.0 / 6.0 - ALPHA_ARROWS;

    let top_left = Point {
        x: RADIUS * alpha_plus.cos(),
        y: -RADIUS * alpha_plus.sin(),
    };
    let top_right = Point {
        x: RADIUS * alpha_minus.cos(),
        y: -RADIUS * alpha_minus.sin(),
    };
    let bottom_left = Point {
        x: rt.x - RADIUS * alpha_minus.cos(),
        y: rt.y + RADIUS * alpha_minus.sin(),
    };
    let bottom_right = Point {
        x: rt.x - RADIUS * alpha_plus.cos(),
        y: rt.y + RADIUS * alpha_plus.sin(),
    };

    print_arrow(&top_left, &bottom_left);
    print_arrow(&bottom_right, &top_right);

    // to the left
    let top_left_l = Point {
        x: -top_left.x,
        y: top_left.y,
    };
    let top_right_l = Point {
        x: -top_right.x,
        y: top_right.y,
    };
    let bottom_left_l = Point {
        x: -bottom_left.x,
        y: bottom_left.y,
    };
    let bottom_right_l = Point {
        x: -bottom_right.x,
        y: bottom_right.y,
    };

    print_arrow(&top_left_l, &bottom_left_l);
    print_arrow(&bottom_right_l, &top_right_l);

    // to the top
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

    print_arrow(&right_bottom, &right_top);
    print_arrow(&left_top, &left_bottom);
}

fn print_archs() {
    let rad1: f64 = 4.0;
    // from left to top
    let ang = PI / 6.0 - calc_angle(rad1, rad1, RADIUS);
    let left_a = Point {
        x: -rad1 * ang.cos(),
        y: -rad1 * ang.sin(),
    };
    let ang = calc_angle(rad1, rad1, RADIUS);
    let top_a = Point {
        x: -rad1 * ang.sin(),
        y: rad1 * ang.cos(),
    };
    let arc = Arc {
        origin: left_a,
        destination: top_a,
    };
    arc.tikz_repr();
    //let dotstr = format!(
    //    "\\draw ({:.2},{:.2}) circle [radius=0.1];",
    //    left_a.x, left_a.y
    //);
    //println!("{}", dotstr);
}

fn main() {
    print_circles_centers();
    print_arrows_to_right_and_left_top();
    print_archs();
}
