import fastapi
import uvicorn
from dotenv import load_dotenv
from fastapi.middleware.cors import CORSMiddleware

# Load environment variables
load_dotenv()
load_dotenv(".env.local", override=True)

from api.routes import auth, coins

app = fastapi.FastAPI(title="Brainrot API", version="1.0.0")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(coins.router)

if __name__ == '__main__':
    uvicorn.run(
        app, host="0.0.0.0", port=8000
    )
