# Pattern Recognition System

## Pattern Categories
The system recognizes the following pattern types:

### 1. Market Manipulation Patterns
```typescript
MANIPULATION_PATTERNS = {
    wash_trading: {
        indicators: {
            circular_trades: true,
            time_window: 300,          // 5 minutes
            volume_similarity: 0.95,    // 95% volume match
            address_correlation: 0.9    // 90% address match
        },
        confidence_threshold: 0.95
    },
    
    price_manipulation: {
        indicators: {
            sudden_spikes: true,
            recovery_time: 600,        // 10 minutes
            price_deviation: 0.1,      // 10% change
            volume_profile: "IRREGULAR"
        },
        confidence_threshold: 0.92
    }
}
```

### 2. Whale Activity Patterns
```typescript
WHALE_PATTERNS = {
    accumulation: {
        minimum_position: 1000000,     // $1M USD
        time_window: 3600,            // 1 hour
        buy_frequency: "SYSTEMATIC",
        volume_consistency: 0.8
    },
    
    distribution: {
        position_size: 1000000,       // $1M USD
        time_frame: 7200,            // 2 hours
        sell_pattern: "CONTROLLED",
        recipient_diversity: 0.7
    }
}
```
```

# Now, let's create the JSON configuration files:

# File 3: src/configs/detection.json
```json
{
  "version": "2.0.0",
  "detection_parameters": {
    "volume_thresholds": {
      "critical": {
        "multiplier": 3.0,
        "timeframe_seconds": 3600,
        "minimum_value_usd": 1000000
      },
      "high": {
        "multiplier": 2.0,
        "timeframe_seconds": 1800,
        "minimum_value_usd": 500000
      },
      "moderate": {
        "multiplier": 1.5,
        "timeframe_seconds": 900,
        "minimum_value_usd": 250000
      }
    },
    "pattern_recognition": {
      "confidence_thresholds": {
        "manipulation": 0.95,
        "whale_activity": 0.90,
        "market_impact": 0.85
      },
      "minimum_data_points": 10,
      "analysis_window_seconds": 3600
    },
    "alert_conditions": {
      "immediate": {
        "score_threshold": 90,
        "response_time_seconds": 60
      },
      "high_priority": {
        "score_threshold": 70,
        "response_time_seconds": 300
      },
      "standard": {
        "score_threshold": 50,
        "response_time_seconds": 900
      }
    }
  }
}
```

# File 4: src/schemas/event.schema.json
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Blockchain Event",
  "description": "Schema for blockchain event detection and classification",
  "type": "object",
  "required": [
    "event_id",
    "timestamp",
    "type",
    "metrics",
    "classification"
  ],
  "properties": {
    "event_id": {
      "type": "string",
      "description": "Unique identifier for the event"
    },
    "timestamp": {
      "type": "integer",
      "description": "Unix timestamp of event detection"
    },
    "type": {
      "type": "string",
      "enum": ["VOLUME_SPIKE", "PRICE_IMPACT", "PATTERN_MATCH", "WHALE_MOVEMENT"]
    },
    "metrics": {
      "type": "object",
      "required": ["volume", "price_impact", "liquidity_change"],
      "properties": {
        "volume": {
          "type": "object",
          "properties": {
            "amount": {"type": "number"},
            "percent_change": {"type": "number"},
            "timeframe": {"type": "integer"}
          }
        },
        "price_impact": {
          "type": "object",
          "properties": {
            "percent_change": {"type": "number"},
            "significance": {"type": "string"}
          }
        },
        "liquidity_change": {
          "type": "object",
          "properties": {
            "amount": {"type": "number"},
            "percent_change": {"type": "number"}
          }
        }
      }
    },
    "classification": {
      "type": "object",
      "required": ["severity", "confidence", "category"],
      "properties": {
        "severity": {
          "type": "string",
          "enum": ["CRITICAL", "HIGH", "MODERATE", "LOW"]
        },
        "confidence": {
          "type": "number",
          "minimum": 0,
          "maximum": 1
        },
        "category": {
          "type": "string"
        }
      }
    }
  }
}
```
