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
    fn print_tikz_repr(&self, add_to_end_angle: f64, add_to_start_angle: f64) {
        let rad = (self.origin.x.powf(2.0)+self.origin.y.powf(2.0)).powf(0.5);
        let start = (-self.destination.x/ self.destination.y).atan();
        let stop = (self.origin.x / self.origin.y).atan();
        let start_angle = 180.0*((PI/2.0 + start)/PI) + add_to_start_angle;
        let stop_angle = 180.0*((1.5*PI-stop)/PI) + add_to_end_angle;

        let tikz_str = format!(
            "\\draw ({:.2},{:.2}) arc [radius={:.2}, start angle = {:.2}, end angle = {:.2}];",
            self.destination.x, self.destination.y, rad,start_angle, stop_angle
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
    let rad2: f64 = 4.3;
    // from left to top
    print_arc(rad1);
    print_arc(rad2);

}

fn print_arc(rad: f64){
    let ang1 = PI / 6.0 - calc_angle(rad, rad, RADIUS);
    let ang2 = calc_angle(rad, rad, RADIUS);
    let ang3 = PI / 6.0 + calc_angle(rad, rad, RADIUS);

    let left = Point {
        x: -rad * ang1.cos(),
        y: -rad * ang1.sin(),
    };

    let right = Point {
        x: - left.x,
        y: left.y,
    };

    let top_l = Point {
        x: -rad * ang2.sin(),
        y: rad * ang2.cos(),
    };

    let top_r =Point{
        x: - top_l.x,
        y: top_l.y
    };

    let left_bottom = Point{
        x: -rad * ang3.cos(),
        y: -rad * ang3.sin()
    };
    let right_bottom = Point{
        x: - left_bottom.x,
        y: left_bottom.y,
    };

    let arc_l = Arc {
        origin: left,
        destination: top_l,
    };
    let arc_r = Arc {
        origin: right,
        destination: top_r,
    };
    let arc_b = Arc{
        origin: left_bottom,
        destination: right_bottom,
    };
    arc_l.print_tikz_repr(0.0, 0.0);
    arc_r.print_tikz_repr(-360.0, 0.0);
    arc_b.print_tikz_repr(0.0, 180.0);

}

fn main() {
    print_circles_centers();
    print_arrows_to_right_and_left_top();
    print_archs();
}
