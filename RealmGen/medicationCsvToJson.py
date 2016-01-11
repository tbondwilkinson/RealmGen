import csv
import argparse
import json

TO_INT_DICTS = {
    "deliveryMechanism": {
        "Inhaler": 1,
        "Nebulizer": 2,
        "Tablet": 3,
        "Injection": 4
    }, "dosageUnit": {
        "Puff": 1,
        "Vial": 2,
        "Capsule": 3,
        "Tablet": 4,
        "Injection": 5
    }, "function": {
        "Controller": 1,
        "Rescue": 2,
        "Both": 3
    }
}

STRING_TO_INT_FIELDS = [
    "dosageMin", "dosageMax", "frequencyMin", "frequencyMax"]

INTERNAL_FIELDS = [
    "deliveryMechanism", "dosageUnit", "function"
]

def main(args):
    medicationJsonOut = {
        "modelName": "StaticMedicationRealm",
        "objects": []
    }
    with open(args.input_csv) as csvfile:
        medication_reader = csv.DictReader(csvfile)
        for medicationDict in medication_reader:
            for internal_field in INTERNAL_FIELDS:
                if medicationDict.has_key(internal_field):
                    delivery_mechanism = medicationDict[internal_field]
                    del medicationDict[internal_field]
                    medicationDict[internal_field + "Internal"] = (
                        TO_INT_DICTS[internal_field][delivery_mechanism]
                    )
            for string_field in STRING_TO_INT_FIELDS:
                if medicationDict.has_key(string_field):
                    medicationDict[string_field] = int(
                        medicationDict[string_field])
            medicationJsonOut["objects"].append(medicationDict)
    with open(args.output_json, 'w') as json_out:
        json.dump(medicationJsonOut, json_out)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_csv", type=str)
    parser.add_argument("output_json", type=str)
    main(parser.parse_args())
