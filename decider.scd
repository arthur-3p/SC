~openTempo = TempoClock.new(30/60);

(SynthDef.new(\1, {
	arg filter=600, freq=400, filterRel, gain = 1, dec = 4;
	var env, sig, filt, hiPass, pan;
	env = EnvGen.kr(Env.new([0,1,0], [0, dec], [1, -4]), doneAction:2);
	sig = SinOscFB.ar(SinOsc.kr(20, 0, 5)+freq*2, 1);
	sig = sig * env*0.2 * gain;
	hiPass = BHiPass.ar(sig, 100, 2);
	hiPass = Pan2.ar(hiPass, SinOsc.kr(2, 0, 0.3));
	Out.ar(0, hiPass);
}).add;)

(SynthDef.new(\2, {
	arg filter=600, rel, freq=100, gain=1, dec = 8;
	var env, sig, filt;
	env = EnvGen.kr(Env.new([0,1,0], [0.1, dec], [0.75, -5]), doneAction:2);
	sig = {Saw.ar(exprand(0.5, 2)+freq)}!2;
	sig = sig * env* 0.2* gain;
	filt = BLowPass.ar(sig, 12000, 10);
	filt = Pan2.ar(filt, SinOsc.kr(1.5, 0, 0.5));
	Out.ar(0, filt);
}).add;)


(Pdef(\synth1).play(~openTempo);
Pdef(\synth2).play;(~openTempo);
Pdef(\synth3).play(~openTempo);
)

(Pdef(\synth1, Pbind(\instrument, \1,
	\freq, Pxrand([49,51,54, 56,58,61,63,66,68], inf).midicps,
	\dur, Prand([0.15, 0.3], inf),
	\dec, 3,
	\gain, 0.7
));)
Pdef(\synth1).stop;

(Pdef(\synth2, Pbind(\instrument, \2,
	\freq, Prand(#[54,61,58,63,66], inf).midicps,
	\dur, Pseq([0.6, 0.6, 0.6, 0.3, 0.3], inf),
	\dec, 0.5,
	\gain, 0
));)

(Pdef(\synth3, Pbind(\instrument, \2,
	\freq, Pxrand(#[54,61,58,63,66], inf).midicps/2,
	\dur, Prand([0.6, 0.6, 0.6, 0.3, 0.3], inf),
	\dec, 6,
	\gain, 0.9
));)


Pdef(\synth1).stop;
Pdef(\synth2).stop;
Pdef(\synth3).stop;