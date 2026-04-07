/**
 * tagsBadge — Renders Tags__c multi-select picklist values as colored badges.
 * Works on any object that has a Tags__c field (Lead, Account, etc.).
 * Uses Lightning Data Service (no Apex required).
 */
import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

const TAGS_FIELD = 'Tags__c';

/**
 * Color categories for tags.
 * Tags not listed here default to 'neutral'.
 * To change a tag's color, move it to the desired category.
 */
const COLOR_MAP = {
    error: [
        'BLACK LIST',
        'NÃO QUALIFICADO',
        'NÃO QUALIFICADO - RAMO DE ATUAÇÃO'
    ],
    warning: [
        'URGENTE',
        'LEAD QUENTE'
    ],
    info: [
        'EM CONTATO COM O EXECUTIVO',
        'EM CONTATO COM O FINDER',
        'FUNIL SDR',
        'LEAD INBOUND'
    ],
    success: [
        'CLIENTE DA BASE',
        'CLIENTE MOVIDESK'
    ],
    warm: [
        'LEAD MORNO',
        'EM NUTRIÇÃO'
    ]
};

// Build reverse lookup: tag value -> color category
const TAG_TO_COLOR = {};
for (const [color, values] of Object.entries(COLOR_MAP)) {
    for (const value of values) {
        TAG_TO_COLOR[value] = color;
    }
}

export default class TagsBadge extends LightningElement {
    @api recordId;
    @api objectApiName;

    rawValue;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: '$fieldReference'
    })
    wiredRecord({ data }) {
        if (data) {
            this.rawValue = getFieldValue(data, this.fieldReference[0]);
        }
    }

    /**
     * Builds the fully qualified field reference dynamically
     * based on the object the component is placed on.
     */
    get fieldReference() {
        if (!this.objectApiName) return undefined;
        return [`${this.objectApiName}.${TAGS_FIELD}`];
    }

    /**
     * Returns true when there is at least one tag to display.
     */
    get hasTags() {
        return this.tags && this.tags.length > 0;
    }

    /**
     * Splits the semicolon-separated picklist value and maps each
     * tag to an object with label, value (for key), and CSS class.
     */
    get tags() {
        if (!this.rawValue) return [];
        return this.rawValue.split(';').map((value) => {
            const label = value.trim();
            const color = TAG_TO_COLOR[label] || 'neutral';
            return {
                label,
                value: label,
                cssClass: `tag tag-${color}`
            };
        });
    }
}