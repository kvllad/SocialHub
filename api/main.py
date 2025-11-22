import fastapi
import uvicorn
from api.routes import auth

app = fastapi.FastAPI(title="Brainrot API", version="1.0.0")

app.include_router(auth.router)

if __name__ == '__main__':
    uvicorn.run(
        app, host="0.0.0.0", port=8000
    )
