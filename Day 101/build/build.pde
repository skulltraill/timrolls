import processing.pdf.*;
boolean record = false;
HDrawablePool pool;
HPolarLayout layout;
HColorPool colors;

void setup(){
	size(640,640,P3D);
	H.init(this).background(#0095A8).use3D(true).autoClear(true);
	smooth();
	frameRate(15);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	// layout = new HPolarLayout(5, 0.8, width / 2, height / 2, false, 0.5);

	pool = new HDrawablePool( 1600 );
	pool.autoAddToStage()
		// .add ( new HPath() )

		// .add(
		// 	new HRect(8)
		// 	.rounding(2)
		// 	.anchor(-100,-30)
		// 	// .noStroke()
		// 	.stroke(#ffffff)
		// 	.noFill()

		// )

		.add(
			new HEllipse(8)
			.anchor(-100,-30)
			.noStroke()
			// .stroke(#ffffff)
			.fill(#ffffff)
			// .noFill()

		)

		.add(
			new HEllipse(4)
			.anchor(-30,-100)
			.noStroke()
			// .stroke(#ffffff)
			.fill(#ffffff)
			// .noFill()

		)

		.layout (
			new HGridLayout()
			.startX(0)
			.startY(100)
			.spacing(30,20)
			.cols(40)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					// HPath d = (HPath) obj;
					// d
					// 	.polygon( 4 )
					// 	.size(5,50)
					// 	.strokeWeight(1)
					// 	.stroke( colors.getColor(i*100) )
					// 	.fill( #181818 )
					// 	.anchor(25,-100)
					// ;

					HDrawable d = (HDrawable) obj;

					// d.stroke( colors.getColor(i) );

					// layout.applyLayout(d);

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.X)
					// 	.range(100, 500)
					// 	.speed(.5)
					// 	.freq(2)
					// 	// .waveform(H.TRIANGLE)
					// 	.currentStep( i )
					// ;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(300, 400)
						.speed(1)
						.freq(2)
						// .waveform(H.TRIANGLE)
						.currentStep( i )
					;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.SCALE)
					// 	.range(0.25, 1.25)
					// 	.speed(1)
					// 	.freq(3)
					// 	// .waveform(H.SAW)
					// 	// .currentStep( i )
					// ;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(0, 360)
						.speed(1)
						.freq(2)
						// .waveform(H.SAW)
						.currentStep( i+100 )
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(-200, 200)
						.speed(1)
						.freq(2)
						.waveform(H.SAW)
						.currentStep( i )
					;


				}
			}
		)
		.requestAll()
	;
}
 
void draw(){
	H.drawStage();
   	   if(frameCount % 1 == 0 && frameCount < 180){
		saveFrame("../frames/image-#####.png");
	}

}


// +        = redraw() advances 1 iteration 
// r        = render to PDF
// c        = recolor 


void keyPressed() {
	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}

	// if (key == '+') {
	// 	drawThings();
	// }

	if (key == 'r') {
		record = true;
		saveFrame("png/render_####.png");
		saveVector();
		H.drawStage();
	}

	if (key == 'c') {

			for (HDrawable temp : pool) {
			HShape d = (HShape) temp;
			d.randomColors(colors.fillOnly());
		}

		// 	for (HDrawable temp : pool2) {
		// 	HShape d = (HShape) temp;
		// 	d.randomColors(colors.fillOnly());
		// }
		
		// 	for (HDrawable temp : pool3) {
		// 	HShape d = (HShape) temp;
		// 	d.randomColors(colors.fillOnly());
		// }
		
		// 	for (HDrawable temp : pool5) {
		// 	HShape d = (HShape) temp;
		// 	d.randomColors(colors.fillOnly());
		// }

		H.drawStage();
	}
}


void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}