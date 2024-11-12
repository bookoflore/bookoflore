// Type definitions for event detection system

export interface BlockchainEvent {
    eventId: string;
    timestamp: number;
    chainId: number;
    eventType: EventType;
    metrics: EventMetrics;
    classification: EventClassification;
}

export enum EventType {
    VOLUME_SPIKE = 'VOLUME_SPIKE',
    PRICE_IMPACT = 'PRICE_IMPACT',
    PATTERN_MATCH = 'PATTERN_MATCH',
    WHALE_MOVEMENT = 'WHALE_MOVEMENT'
}

export interface EventMetrics {
    volume: {
        amount: number;
        percentChange: number;
        timeframe: number;
    };
    priceImpact: {
        percentChange: number;
        significance: string;
    };
    liquidityChange: {
        amount: number;
        percentChange: number;
    };
}

export interface EventClassification {
    severity: 'CRITICAL' | 'HIGH' | 'MODERATE' | 'LOW';
    confidence: number;
    category: string;
}
