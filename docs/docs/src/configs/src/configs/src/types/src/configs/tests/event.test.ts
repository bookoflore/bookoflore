import { describe, expect, test } from '@jest/globals';
import { EventClassifier } from '../src/classifiers/event';

describe('Event Classification System', () => {
    const classifier = new EventClassifier();

    test('should correctly classify volume spikes', () => {
        const testEvent = {
            volume: 1000000,
            timeframe: 300,
            priceImpact: 0.05
        };

        const classification = classifier.classify(testEvent);
        
        expect(classification.severity).toBe('HIGH');
        expect(classification.confidence).toBeGreaterThan(0.9);
    });

    test('should detect wash trading patterns', () => {
        const transactions = [
            // Test transaction data
        ];

        const pattern = classifier.detectWashTrading(transactions);
        
        expect(pattern.isWashTrading).toBe(true);
        expect(pattern.confidence).toBeGreaterThan(0.95);
    });
});
