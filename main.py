from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from controller.counter_controller import router as counter_router

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:3000", "http://127.0.0.1:60621"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(counter_router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
