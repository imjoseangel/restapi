from datetime import datetime
from config import db, ma


class Inventory(db.Model):
    __tablename__ = "inventory"
    inventory_id = db.Column(db.Integer, primary_key=True)
    appid = db.Column(db.String(32))
    hname = db.Column(db.String(32))
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)


class InventorySchema(ma.ModelSchema):
    class Meta:
        model = Inventory
        sqla_session = db.session
