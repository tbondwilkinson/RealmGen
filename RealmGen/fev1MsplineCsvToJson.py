import csv
import argparse
import json

def main(args):
    msplineJsonOut = {
        "modelName": "StaticMsplineRealm",
        "objects": []
    }
    with open(args.input_csv) as csvfile:
        msplineReader = csv.DictReader(csvfile)
        for msplineDict in msplineReader:
            if msplineDict.has_key('age'):
                msplineDict['ageTimesFour'] = int(float(msplineDict['age']) * 4)
                del msplineDict['age']
            for key in ['male', 'female']:
                if msplineDict.has_key(key):
                    msplineDict[key] = float(msplineDict[key])
            msplineJsonOut["objects"].append(msplineDict)
    with open(args.output_json, 'w') as json_out:
        json.dump(msplineJsonOut, json_out)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input_csv", type=str)
    parser.add_argument("output_json", type=str)
    main(parser.parse_args())
