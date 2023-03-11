// API Script for Character Template Projectile

var X_SPEED = 14; // X speed of water
var Y_SPEED = 0; // Y Speed of water

// Instance vars
var life = self.makeInt(60 * 1);
var originalOwner = null;

function initialize(){
	self.addEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit, { persistent: true });
	self.addEventListener(GameObjectEvent.HIT_DEALT, onHit, { persistent: true });
	originalOwner = self.getOwner();

	self.setCostumeIndex(self.getOwner().getCostumeIndex());

    // Set up horizontal reflection
	Common.enableReflectionListener({ mode: "X", replaceOwner: true });
	self.setState(PState.ACTIVE);
	self.setXSpeed(X_SPEED);
	self.setYSpeed(Y_SPEED);
}

function onGroundHit(event) {
	die();
}

function onHit(event) {
	die();
}


function die(){
	missileSub(1);
	self.removeEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit);
	self.removeEventListener(GameObjectEvent.HIT_DEALT, onHit);

	self.toState(PState.DESTROYING);
}

function missileSub(num){
	originalOwner.setX(100);
	originalOwner.setX(originalOwner.exports.missiles.get());
	originalOwner.exports.missiles.set(0);
}

function update() {
	if (self.inState(PState.ACTIVE)) {
		life.dec();
		if (life.get() <= 0) {
			die();
		}
	}
}

function onTeardown() {
	missileSub(1);
	self.removeEventListener(EntityEvent.COLLIDE_FLOOR, onGroundHit);
	self.removeEventListener(GameObjectEvent.HIT_DEALT, onHit);
}