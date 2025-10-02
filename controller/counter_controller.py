from fastapi import APIRouter

router = APIRouter(prefix="/counter", tags=["Counter"])

counter = 0

@router.get("/")
def get_counter():
    return {"value": counter}

@router.post("/increment")
def increment_counter():
    global counter
    counter += 1
    return {"value": counter}
