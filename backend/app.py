from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_restful import Api, Resource
import firebase_admin
from firebase_admin import credentials, db, messaging
import os
from dotenv import load_dotenv
import logging

load_dotenv()

app = Flask(__name__)
CORS(app)
api = Api(app)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

try:
    cred = credentials.Certificate('backend/firebase-key.json')
    firebase_admin.initialize_app(cred, {
        'databaseURL': os.getenv('FIREBASE_DATABASE_URL')
    })
    logger.info('Firebase initialized')
except Exception as e:
    logger.error(f'Firebase initialization error: {e}')


class HealthCheck(Resource):
    def get(self):
        return {'status': 'ok', 'service': 'SSD Results API'}, 200


class ResultsCheck(Resource):
    def post(self):
        try:
            data = request.get_json()
            index_number = data.get('index_number')
            exam_type = data.get('exam_type')
            
            if not index_number or not exam_type:
                return {'error': 'Missing index_number or exam_type'}, 400
            
            ref = db.reference(f'results/{exam_type}/{index_number}')
            result = ref.get()
            
            if result:
                return {'status': 'found', 'data': result}, 200
            else:
                return {'status': 'not_found', 'message': 'Results not published yet'}, 404
        
        except Exception as e:
            logger.error(f'Error checking results: {e}')
            return {'error': str(e)}, 500


class DigitelUSSD(Resource):
    """Generate Digitel *113# USSD code for fallback"""
    def post(self):
        try:
            data = request.get_json()
            index_number = data.get('index_number')
            exam_type = data.get('exam_type')  # PLE, S4, S8
            
            if not index_number or not exam_type:
                return {'error': 'Missing index_number or exam_type'}, 400
            
            # Digitel *113# format
            ussd_code = '*113#'
            
            return {
                'status': 'ready',
                'ussd_code': ussd_code,
                'exam_type': exam_type,
                'index_number': index_number,
                'instructions': [
                    '1. Dial *113# on your Digitel SIM',
                    '2. Select option for exam type (PLE/S4/S8)',
                    '3. Enter your index number: ' + index_number,
                    '4. Wait 5-20 minutes for SMS with results',
                    '5. Cost: ~100 SSP'
                ],
                'cost': '~100 SSP',
                'estimated_time': '5-20 minutes'
            }, 200
        
        except Exception as e:
            logger.error(f'Error generating USSD code: {e}')
            return {'error': str(e)}, 500


class Leaderboard(Resource):
    def get(self):
        try:
            exam_type = request.args.get('exam_type', 'S4')
            limit = int(request.args.get('limit', 100))
            
            ref = db.reference(f'leaderboard/{exam_type}')
            leaderboard = ref.order_by_child('score').limit_to_last(limit).get()
            
            return {'status': 'ok', 'data': leaderboard}, 200
        
        except Exception as e:
            logger.error(f'Error fetching leaderboard: {e}')
            return {'error': str(e)}, 500


class CountdownTimer(Resource):
    def get(self):
        try:
            exam_type = request.args.get('exam_type', 'S4')
            
            ref = db.reference(f'exams/{exam_type}')
            exam_info = ref.get()
            
            if exam_info:
                return {'status': 'ok', 'data': exam_info}, 200
            else:
                return {'status': 'not_found'}, 404
        
        except Exception as e:
            logger.error(f'Error fetching countdown: {e}')
            return {'error': str(e)}, 500


class PushNotification(Resource):
    def post(self):
        try:
            data = request.get_json()
            user_token = data.get('user_token')
            title = data.get('title')
            body = data.get('body')
            
            message = messaging.Message(
                notification=messaging.Notification(
                    title=title,
                    body=body,
                ),
                token=user_token,
            )
            
            response = messaging.send(message)
            return {'status': 'sent', 'message_id': response}, 200
        
        except Exception as e:
            logger.error(f'Error sending notification: {e}')
            return {'error': str(e)}, 500


api.add_resource(HealthCheck, '/health')
api.add_resource(ResultsCheck, '/api/results/check')
api.add_resource(DigitelUSSD, '/api/digitel/ussd')
api.add_resource(Leaderboard, '/api/leaderboard')
api.add_resource(CountdownTimer, '/api/countdown')
api.add_resource(PushNotification, '/api/notify')


if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    app.run(debug=os.getenv('FLASK_DEBUG', False), port=port, host='0.0.0.0')
