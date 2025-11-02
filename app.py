import os
import google.genai as genai
from google.genai import types
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

load_dotenv()

# --- Konfigurasi Awal ---
app = Flask(__name__)
# CORS penting untuk mengizinkan HTML Anda mengakses server ini
CORS(app) 

# --- Konfigurasi Klien Gemini ---
try:
    genai.Client(api_key=os.getenv("GEMINI_API_KEY"))
except AttributeError as e:
    print(f"Error: {e}")
    print("Pastikan Anda sudah mengatur 'GEMINI_API_KEY' sebagai environment variable.")
    exit()

# Gunakan model gambar dari skrip Anda
model= "gemini-2.5-flash" 

# --- Ini adalah "System Instruction" Anda ---
SYSTEM_INSTRUCTION = """kamu adalah seorang ahli edukator seks dengan pengalaman 30 tahun memberikan informasi dan sumber daya mengenai berbagai aspek seksualitas manusia kepada anak di bawah umur. tugas mu adalah membawa percakapan tentang edukasi seks dan menjawab pertanyaan anak - anak yang berkaitan dengan edukasi seks. Jelaskan jawaban dengan konsep ilmiah yang mudah dimengert oleh anak. Gunakan humor juga dalam percakapan agar membuat percakapan yang menarik dan eduaktif. Tanyakan sebuah pertanyaan sehingga kamu bisa mengerti perilaku pengguna  dan meningkatkan pengetahuan mereka. Ajarkan juga anak observasi studi kasus dengan situasi di dunia nyata sekarang sehingga dapat meningkatakan kesadaran akan pentingnya pendidikan seksual."""

# --- Buat "API Endpoint" ---
@app.route('/chat', methods=['POST'])
def chat():
    try:
        #  Dapatkan pesan pengguna dari permintaan HTML (dalam format JSON)
        user_message = request.json['message']

        if not user_message:
            return jsonify({"error": "Pesan tidak boleh kosong"}), 400

        #  Siapkan konten untuk dikirim ke Gemini
        contents = [
            types.Content(
                role="user",
                parts=[
                    types.Part.from_text(text=user_message),
                ],
            ),
        ]
        
        # Minta TEKS dan GAMBAR, sesuai skrip Anda
        generate_config = types.GenerateContentConfig(
            response_modalities=[
                "TEXT"
            ],
            
        )
        
        # Siapkan model dengan instruksi sistem
        client = genai.Client()

        response = client.models.generate_content(
            model=model,
            contents=contents,
            config=types.GenerateContentConfig(system_instruction=[types.Part.from_text(text=SYSTEM_INSTRUCTION)]
             ),
        )

        #  Proses respons 
        text_response = ""
       

        for part in response.candidates[0].content.parts:
            if part.text:
                text_response += part.text
            

        #  Kirim kembali Teks dan Gambar (Base64) ke HTML
        return jsonify({
            "text": text_response,
            
        })

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"error": str(e)}), 500

# --- Jalankan Server Flask ---
if __name__ == '__main__':
    # Server akan berjalan di http://127.0.0.1:5000/
    app.run(port=5000, debug=True)
